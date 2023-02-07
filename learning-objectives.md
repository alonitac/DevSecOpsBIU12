# Session I (13/1)

### Covered content

- Welcome: [README.md](README.md)
- [bash/01_intro.md](bash/01_intro.md)
- [bash/02_bash-and-other-animals.md](bash/02_bash-and-other-animals.md)



### Mandatory for all students

- Complete the module onborading - install Git, Pycharm, create GitHub account.
- Do [exercise 1](ex1/)

### General topics

- Waterfall model vs Agile
- Git vs GitHub
- Relative vs absolute Linux paths
- What are application logs? 

### Bash

- Get yourself to know how to work with some Terminal text editor (`nano`, `vi`). We will work in class with `nano`.
- Understand the Linux file permission [binary representation](https://en.wikipedia.org/wiki/File-system_permissions#Numeric_notation).

### Understanding `sudo`

Execute the following comamnds from your home (`~`) directory.

1. Create a new linux user in your system.
2. Use `sudo` to switch to the new created user (`-u` flag) and try to `mkdir` some new dir. 

What happened? did you succeed?  Why?

### Optional resources 

- Open source licenses https://choosealicense.com/
- The pre-commit Git tool https://pre-commit.com/

# Session II (17/1) + Session III (20/1)

### Covered content

- [bash/03_the-PATH.md](bash/03_the-PATH.md)
- [bash/04_processes.md](bash/04_processes.md)
- [bash/05_debugging.md](bash/05_debugging.md)
- [bash/07_bash-conf-files.md](bash/07_bash-conf-files.md)
 

### Terminate a script on error

Given a Bash script with multiple lines, Bash by default executes the commands one by one regardless the exit-code of each command (we've seen in class that even when command is failing, Bash continues to the next command). 
Sometimes, it's necessary to exit immediately on the first command failure.

Write some Bash program that intentionally contains some errors, execute the program first using `bash myscript.sh`, then with `bash -e myscript.sh`.

What `-e` does? 

### ' vs " in `echo`

Read the [following StackOverflow thread](https://stackoverflow.com/questions/6697753/difference-between-single-and-double-quotes-in-bash) discussed the differences between single and double quote in Bash. 

### io redirection

- Make sure you understand the difference between `>` and `>>`.
- Make sure you understand the role of `|` (our [book](https://tldp.org/LDP/abs/abs-guide.pdf) page 19).

### Restricted Bash (`rbash`)

Which of the following actions are not allowed in `rbash`?

  - Change the $PATH env var
  - Change $USER env var
  - `cd` to a directory
  - Redirect output to a file
  - Define a local variable

### Order of paths in $PATH

We've seen in class that the environment variable $PATH consists of list of path to binaries (usually `/usr/bin/`, `/usr/local/bin`, etc), separated by colons (`:`).
When given a command, the shell automatically searches on the directories listed in
the path for the executable. Normally, the system stores the $PATH definition in
`/etc/profile` and/or `~/.bashrc`

Open a new terminal session and validate that the order of the paths list is important - 
add two new paths of directories contain the same command (the same executable) and make sure that the command in the path appears first is executed. 


### Process forking 

Attached are some useful resources regarding process forking in Linux systems

- https://www.csl.mtu.edu/cs4411.ck/www/NOTES/process/fork/create.html
- https://www.youtube.com/watch?v=r16PoQCedUA

# Session IV (24/1) + Session V (27/1)

### Covered content

- [bash/08_variables_deep_dive.md](bash/08_variables_deep_dive.md)
- [bash/09_conditional_statements.md](bash/09_conditional_statements.md)

### Mandatory for all students

- Complete the [exercise](bash/09_conditional_statements.md#exercise) we started in class.
- Review [string-comparisons](bash/09_conditional_statements.md#string-comparisons) and [if-grep-construct](bash/09_conditional_statements.md#if-grep-construct) sections.
- Do [exercise 2](ex2/)

### General terms and concepts to overview

- RESTful API: https://www.redhat.com/en/topics/api/what-is-a-rest-api
- HTTP Protocol overview: https://developer.mozilla.org/en-US/docs/Web/HTTP/Overview
- Read some information about "hash tables", about md5 algorithm and try to use the `md5sum` command to has some text. 

### ShellCheck 

1. First, get familiar with the concept of Linting: - Linting: https://en.wikipedia.org/wiki/Lint_(software)

2. In this section we will use a Bash linter called ShellCheck to lint your `bash_ex1` solution. 

3. In the official GitHub page, you'll find the [installation guide](https://github.com/koalaman/shellcheck#installing) for many systems. Find your right installation command, and install ShellCheck. 

4. Read the [how to use](https://github.com/koalaman/shellcheck#from-your-terminal) section, invoke `shellcheck` from your terminal that lints your solution. Review the output. 

### Variable reference using curly braces `${}`

We've discussed in class regarding the use of curly braces `${}` when referencing a variable in Bash. Read the chapter on [Parameter Substitution](https://tldp.org/LDP/abs/html/parameter-substitution.html) to see more examples.

# Session VI (31/1) + Session VII (03/2)

### Covered content

- [bash/10_loops.md](bash/10_loops.md)
- [bash/11_functions.md](bash/11_functions.md)

- [databases/relational-db.md](databases/relational-db.md)
- [databases/no-sql-db.md](databases/no-sql-db.md)




### Databases overview - key concepts

Here are the key concepts for relational(SQL) and NoSQL databases:

#### SQL databases

- Fixed schema: the structure of the tables and the types of data is defined in advance. Schema modification is hard work.
- Use structured query language (SQL) for querying and manipulating data.
- Are optimized for complex queries, for applications that require strong consistency and reliability.
- Use a relational model to store data, organizing it into tables with rows and columns and using relationships between tables.

The big players: 

- MySQL: An open-source relational database management system that is widely used for web-based applications.
- PostgreSQL: An open-source object-relational database management system that is known for its reliability, stability, and robust feature set.
- Microsoft SQL Server: A commercial relational database management system developed by Microsoft, suitable for both small and large-scale enterprise applications.
- Oracle Database: A commercial relational database management system developed by Oracle Corporation, offering advanced features for data warehousing, OLAP, and business intelligence.

#### NoSQL databases

- Flexible schema: the structure of the database can be changed dynamically without affecting the data it stores.
- Use a variety of query languages, including SQL-like languages, JavaScript, and others, depending on the type of database.
- Are optimized for high availability (HA), high performance, scalability, and ease of use, making them suitable for applications that handle large amounts of unstructured or semi-structured data.
- Use a variety of data models, including document, key-value, graph, and others, depending on the type of database.

The big players: 

- MongoDB: A document-oriented database that uses JSON-like documents to store data.
- Cassandra: A highly scalable and available distributed database that uses a column-based data model.
- Redis: An in-memory key-value store that supports a wide range of data structures and is often used as a cache or message broker.
- DynamoDB: A fully managed NoSQL database service provided by Amazon Web Services (AWS).
- Elasticsearch: A search engine based on the Lucene library that supports full-text search and real-time analytics. It can be used as a stand-alone search engine or as part of the ELK stack (Elasticsearch, Logstash, and Kibana) for log analysis and data visualization.
- InfluxDB: A time series database that is optimized for storing and processing time-stamped data, such as metrics and events. It supports SQL-like queries and includes a built-in HTTP API for data ingestion and retrieval.

In summary, the choice between SQL and NoSQL databases depends on the specific requirements of the application, such as the type and structure of data, performance and scalability needs, and the complexity of querying and processing the data.


### Functions practice 

At the end of [bash/11_functions.md](bash/11_functions.md) you'll find a few empty bash functions, you are highly encouraged to implement the function body according to the instructions.    

### Logical operators (`&&`, `||`)

Get yourself familiar with bash logical operators, read the **logical (boolean) operators** section in [our book](https://tldp.org/LDP/abs/html/ops.html) 
