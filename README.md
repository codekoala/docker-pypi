PyPI Server
===========

This is a simple PyPI server that can be used to host internal packages and
versions of packages that are suitable for use with proprietary products.

Usage
-----

You can build a new, up-to-date version of the container using the:

    make build

command. This will create a new container that just has the latest version of
``pypiserver`` installed and ready to serve packages out of ``/srv/pypi``. To
use this container, run:

    make run

This will spin up the ``pypi-server`` command within container, and it will be
exposed on port ``1280`` on your host system. To test that the container is
working, visit http://localhost:8080 in your browser.

Adding Internal Packages
------------------------

Internal packages may be uploaded to this PyPI server quite easily. The first
step is to create a user account::

    htpasswd -s htaccess yourusername

.. important::

    You will probably need to re-run ``make run`` each time you update the
    htaccess file, as it will copy the password file to the correct location
    before launching the server.

    Alternatively, you might be able to just copy the ``htaccess`` file to
    ``/srv/pypi/.htaccess`` after each change without restarting your PyPI
    container.

This command (included with Apache on most distributions) will prompt you for a
password for ``yourusername``. You should use a more appropriate username, and
enter a password that you want to use to "secure" your PyPI uploads. Then edit
your ``~/.pypirc`` (create it if necessary), replacing both `yourusername` and
`yourpassword` with the values used with the ``htpasswd`` command::

    [distutils]
    index-servers =
        pypi
        internal

    [pypi]
    username:pypiusername
    password:pypipassword

    [internal]
    repository: http://localhost:8080
    username:yourusername
    password:yourpassword

Next, you should be able to go into any Python project with a valid
``setup.py`` file and run::

    python setup.py sdist upload -r internal

Assuming the container is online and your credentials are correct, this should
add a package with the project contents to the internal PyPI server.

Adding Third Party Packages
---------------------------

Third party packages can be mirrored on the PyPI server by using a command such
as::

    pip install -d /srv/pypi pkgname

If you have a requirements file for a project's dependencies, you can easily
mirror all dependencies by running::

    pip install -d /srv/pypi -r requirements.txt

Be careful to use the correct version of ``pip``--sometimes you might want to
run ``pip2`` and other times ``pip3``.

Updating Mirrored Packages
--------------------------

You can update the packages mirrored on the internal PyPI server by running::

    pypi-server -U /srv/pypi

Each package in the repo will be checked for updates, and instructions for
updating the repo with the latest packages will be displayed.
