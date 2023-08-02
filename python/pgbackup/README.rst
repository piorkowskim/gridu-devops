pgbackup
========

CLI for backup remote PGSQL database either locally or to S3

Preparing the Development
------------------------
1. Ensure ``pip`` and ``pipenv`` are installed
2. Clone repository: ``git clone git@github.com:piorkowskim/gridu-devops.git``
3. ``cd`` into the repository.
4. Fetch development dependencies ``make install``
5. Activate virtualenv: ``pipenv shell``

Usage
-----
Pass in a full DB URL, the storage driver, and the destination.

S3 Example w/ bucket name:

::

    $ pgbacckup postgres://bob@example.com:5432/db_one --driver s3 backups

Local Example w/ local path:

::

    $ pgbackup postgres://bob@example.com:5432/db_one --driver local /var/local/db_one/backups/dump.sql



Running Tests
--------------

Run tests locally using ``make`` if virtualenv is active:

::

    $ make

If virtualenv isnt active then use:

::

    $ pipenv run make
