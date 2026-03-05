# PascalPress

The goal of this software will be to create a usable front-end suitable for use in custom HTML/CSS templates which acts as the glue and logic between the content and a compatible REST API backend server.

There will be a sample server provided in this project which will be built in ObjectPascal as well, but it is not required to use the front-end publishing client which the users will see.

One key feature of this software will be in security, whereas, a fully read-only REST API Server with a read-only connection to a compatible database server will be the only requirement.  All administrative tasks will instead take place in a dedicated desktop app which will initially communicate directly to the database, over an SSH connection for the most secure publishing experience possible.
