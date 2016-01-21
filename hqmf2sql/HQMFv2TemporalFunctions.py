from sqlalchemy import *

class TemporalFunctions:
    @classmethod
    def date_delta(cls, units, d1, d2, inline=True):
        # Logic from Appendix C of
        # http://www.cms.gov/Regulations-and-Guidance/Legislation/EHRIncentivePrograms/Downloads/eCQM_LogicGuidance_v110_May2015.pdf
        # It's not stated explicitly, but they seem to always want positive values as results

        if units == 'year' or units == 'a':
            return cls.year_delta(d1, d2, inline)
        elif units == 'month' or units == 'mo':
            return cls.month_delta(d1, d2, inline)
        elif units == 'week' or units == 'wk':
            return cls.week_delta(d1, d2, inline)
        elif units == 'day' or units == 'd':
            return cls.day_delta(d1, d2, inline)
        else:

            raise NotImplementedError("Date difference with unit " + units + " is not implemented")

    @classmethod
    def year(cls, date):
        return extract('year', date)


    @classmethod
    def month(cls, date):
        return extract('month', date)

    @classmethod
    def day(cls, date):
        return extract('day', date)

    

    @classmethod
    def year_delta(cls, d1, d2, inline=True):
        if not inline:
            return func.year_delta(d1, d2)
        return case([
                (d2 >= d1, cls.signed_year_delta(d1, d2)),
                (d2 < d1, cls.signed_year_delta(d2, d1))],
                    else_ = null())

    @classmethod
    def signed_year_delta(cls, d1, d2):
        return case([
                (cls.month(d2) < cls.month(d1), cls.year(d2) - cls.year(d1) - 1),
                (and_(cls.month(d2) == cls.month(d1), cls.day(d2) >= cls.day(d1)), cls.year(d2) - cls.year(d1)),
                (and_(cls.month(d2) == cls.month(d1), cls.day(d2) < cls.day(d1)), cls.year(d2) - cls.year(d1) - 1),
                (cls.month(d2) > cls.month(d1), cls.year(d2) - cls.year(d1))
                ])
    

    @classmethod
    def month_delta(cls, d1, d2, inline):
        if not inline:
            return func.month_delta(d1, d2)
        return case([
                (d2 >= d1, cls.signed_month_delta(d1, d2)),
                (d2 < d1, cls.signed_month_delta(d2, d2))],
                    else_ = null())

    @classmethod
    def signed_month_delta(cls, d1, d2):
        return case([
                (cls.day(d2) >= cls.day(d1), (cls.year(d2) - cls.year(d1)) * 12 + cls.month(d2) - cls.month(d1)),
                (cls.day(d2) < cls.day(d1), (cls.year(d2) - cls.year(d1)) * 12 + cls.month(d2) - cls.month(d1) - 1)
                ])


    # Per appendix C: "For the purposes of quality measures, duration expressed in weeks ignores the time of day"                
    @classmethod
    def week_delta(cls, d1, d2, inline):
        if not inline:
            return func.week_delta(d1, d2)
        return func.floor(cls.day_delta(d1, d2) / 7)


    # Per appendix C: "For the purposes of quality measures, duration expressed in days ignores the time of day"
    @classmethod
    def day_delta(cls, d1, d2, inline):
        if not inline:
            return func.day_delta(d1, d2)
        return func.abs(cast(d2, Date) - cast(d1, Date))

    @classmethod
    def get_method(cls, name):
        methods = {
            'SBS' : {'func' : cls.compare_svs, 'op' : Column.__lt__, 'inclusive' : Column.__le__},
            'SBSORSCW' : {'func' : cls.compare_svs, 'op' : Column.__le__, 'inclusive' : Column.__le__},
            'SBE' : {'func' : cls.compare_sve, 'op' : Column.__lt__, 'inclusive' : Column.__le__},
            'EBS' : {'func' : cls.compare_evs, 'op' : Column.__lt__, 'inclusive' : Column.__le__},
            'EBE' : {'func' : cls.compare_eve, 'op' : Column.__lt__, 'inclusive' : Column.__le__},
            'SAS' : {'func' : cls.compare_svs, 'op' : Column.__gt__, 'inclusive' : Column.__ge__},
            'SASORSCW' : {'func' : cls.compare_svs, 'op' : Column.__ge__, 'inclusive' : Column.__ge__},
            'SAE' : {'func' : cls.compare_sve, 'op' : Column.__gt__, 'inclusive' : Column.__ge__},
            'SAEORSCWE' : {'func' : cls.compare_sve, 'op' : Column.__ge__, 'inclusive' : Column.__ge__},
            'EAS' : {'func' : cls.compare_evs, 'op' : Column.__gt__, 'inclusive' : Column.__ge__},
            'EAE' : {'func' : cls.compare_eve, 'op' : Column.__gt__, 'inclusive' : Column.__ge__},
            'EAEORECW' : {'func' : cls.compare_eve, 'op' : Column.__ge__, 'inclusive' : Column.__ge__},

            'DURING' : {'func' : cls.add_during},
            'CONCURRENT' : {'func' : cls.add_concurrent},
            'SDU' : {'func' : cls.add_sdu},
            'EDU' : {'func' : cls.add_edu},
            'ECWS' : {'func' : cls.add_ecws},
            'SCW' : {'func' : cls.add_scw},
            'ECW' : {'func' : cls.add_ecw},
            'OVERLAP' : {'func' : cls.add_overlap}
            }
        return methods[name]

    @classmethod
    def process(cls, temporal_params, sel, data_selectable, referrant, inline=True):
        specs = cls.get_method(temporal_params.get_type_code())
        func = specs['func']
        return func(sel, data_selectable, referrant, specs, temporal_params, inline)

    @classmethod
    def temporal_params_to_offset(cls, params, spec):
        if params == None:
            return None
        offset = dict()
        offset['high'] = params.get_high()
        offset['low'] = params.get_low()        
        for key in ['high', 'low']:
            offset[key] = cls.to_offset(range.get(key), spec.get('op'))
        return offset

    @classmethod
    def to_offset(cls, range, operator):
        if range == None:
            return None
        unit = range.get('unit')
        val = int(range.get('value'))
        if operator == Column.__gt__:
            val = val * -1
        if unit == 'a':
            return timedelta(days=(val*365))
        elif unit == 'mo':
            return timedelta(days=(val*30))            
        else:
            raise ValueError('unknown unit ' + unit)

    @classmethod
    def get_initial_comparison_op(cls, specs, temporal_range):
        if temporal_range is None:
            return specs.get('op')
        else:
            return specs.get('inclusive')
            
    @classmethod
    def compare_svs(cls, sel, data_selectable, referrant, specs, temporal_range, inline=True):
        return cls.simple_compare(specs.get('op'), sel, data_selectable.get_start_time(), referrant.get_start_time(), temporal_range, inline)

    @classmethod
    def compare_sve(cls, sel, data_selectable, referrant, specs, temporal_range, inline=True):
        return cls.simple_compare(specs.get('op'), sel, data_selectable.get_start_time(), referrant.get_end_time(), temporal_range, inline)

    @classmethod
    def compare_evs(cls, sel, data_selectable, referrant, specs, temporal_range, inline=True):
        return cls.simple_compare(specs.get('op'), sel, data_selectable.get_end_time(), referrant.get_start_time(), temporal_range, inline)

    @classmethod
    def compare_eve(cls, sel, data_selectable, referrant, specs, temporal_range, inline=True):
        return cls.simple_compare(specs.get('op'), sel, data_selectable.get_end_time(), referrant.get_end_time(), temporal_range, inline)

    @classmethod
    def add_during(cls, sel, data_selectable, referrant, specs, temporal_range, inline=True):
        sel = cls.simple_compare(Column.__ge__, sel, data_selectable.get_start_time(), referrant.get_start_time(), None, inline)
        return cls.simple_compare(Column.__le__, sel, data_selectable.get_end_time(), referrant.get_end_time(), None, inline)

    @classmethod
    def add_overlap(cls, sel, data_selectable, referrant, specs, temporal_range, inline=True):
        if data_selectable is None:
            print("overlap: null data_selectable")
        if referrant is None:
            print("overlap: null referrant") 
        if data_selectable.get_end_time() is None:
            print("overlap: null data end time")                      
        if referrant.get_start_time() is None:
            print("overlap: null referrant start time")                                  
        sel = sel.where(or_(
                and_(not_(data_selectable.get_end_time() < referrant.get_start_time()),
                     not_(referrant.get_end_time() < data_selectable.get_start_time())),
                and_(data_selectable.get_start_time() <= referrant.get_end_time(),
                     data_selectable.get_end_time() == None),
                and_(referrant.get_start_time() <= data_selectable.get_end_time(),
                     referrant.get_end_time() == None),
                and_(data_selectable.get_start_time() == None, data_selectable.get_end_time() == None)))

        return sel

    @classmethod
    def add_concurrent(cls, sel, data_selectable, referrant, specs, temporal_range, outer, inline=True):
        sel = cls.simple_compare(Column.__eq__, sel, data_selectable.get_start_time(), referrant.get_start_time(), None, inline)
        return cls.simple_compare(Column.__eq__, sel, data_selectable.get_end_time(), referrant.get_end_time(), None, inline)

    @classmethod
    def add_sdu(cls, sel, data_selectable, referrant, specs, temporal_range, inline=True):
        return cls.add_xdu(sel, data_selectable.get_start_time(), referrant, inline)

    @classmethod
    def add_edu(cls, sel, data_selectable, referrant, specs, temporal_range, inline=True):
        return cls.add_xdu(sel, data_selectable.get_end_time(), referrant, inline)


    @classmethod
    def add_xdu(cls, sel, time_col, referrant, inline=True):
        sel = cls.simple_compare(Column.__ge__, sel, time_col, referrant.get_start_time(), None, inline)
        return cls.simple_compare(Column.__le__, sel, time_col, referrant.get_end_time(), None, inline)

    @classmethod
    def add_ecws(cls, sel, data_selectable, referrant, specs, temporal_range, inline=True):
        sel = cls.simple_compare(Column.__eq__, sel, data_selectable.get_end_time(), referrant.get_start_time(), None, inline)

    @classmethod
    def add_scw(cls, sel, data_selectable, referrant, specs, temporal_range, inline=True):
        sel = cls.simple_compare(Column.__eq__, sel, data_selectable.get_start_time(), referrant.get_start_time(), None, inline)

    @classmethod
    def add_ecw(cls, sel, data_selectable, referrant, specs, temporal_range, inline=True):
        sel = cls.simple_compare(Column.__eq__, sel, data_selectable.get_end_time(), referrant.get_end_time(), None, inline)

    @classmethod
    def simple_compare(cls, operator, sel, leftcol, rightcol, temporal_params, inline=True):
        if leftcol is None:
            raise ValueError("leftcol is null")
        if rightcol is None:
            raise ValueError("rightcol is null")
        sel = sel.where(operator(leftcol, rightcol))
        if temporal_params == None:
            return sel

        low = temporal_params.get_low()
        high = temporal_params.get_high()
        if low is not None:
            sel = cls.simple_compare_half(sel, Column.__gt__, Column.__ge__, leftcol, rightcol, low.get_value(), low.get_unit(), temporal_params.get_low_closed(), inline)

        if high is not None:
            sel = cls.simple_compare_half(sel, Column.__lt__, Column.__le__, leftcol, rightcol, high.get_value(), high.get_unit(), temporal_params.get_high_closed(), inline)

        return sel

    @classmethod    
    def simple_compare_half(cls, sel, op, closed_op, leftcol, rightcol, value, unit, is_closed, inline):
        if value == None:
            return sel
        if unit == None and value == 0:
            unit = 'd'
        if is_closed:
            return sel.where(closed_op(cls.date_delta(unit, leftcol, rightcol, inline), int(value)))
        else:
            return sel.where(op(cls.date_delta(unit, leftcol, rightcol, inline), int(value)))       
