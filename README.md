# USC-source-code

Requriements
-----------
* [antlr4](http://www.antlr.org) -- must be a command line alias `> alias antlr4='java -jar /usr/local/lib/antlr-4.5.1-complete.jar'`
* [python3](http://python.org) -- version 3.5 or later
* [postgresql](postgresql.org) -- the path to pg_config executable must be available
* [git](http://git-scm.com)

Installing
---------
1. Clone this directory
    ```bash
    > git clone http://github.com/caCDE-QA/USC-source-code
    ```
2. Make a virtual environment for python
    ```bash
    > virtualenv <path>/env
    > ./<path/env/bin/activate
    (env) >
    ```
3. Install dependent packages
    ```bash
    (env) > cd USC-source-code
    (env) > pip install -r requirements.txt
    ```
4. Generate the parser
    ```bash
    (env) > cd hqmf2sql
    (env) > . make_parser.sh
    ```
5. Run the test code
    ```bash
    (env) > ./hqmf2sqlv2.sh test data/phema-bph-use-case.xml
    ```