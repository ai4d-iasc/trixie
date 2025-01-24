The most up-to-date way to see which software has been preinstalled on Trixie is by using the module command. When in double, it is the definitive list.

Software on Trixie is organized using the ``module`` service. Users can load, unload, and swap libraries within their environment and job submission scripts via ``modules``.

If there is a piece of software you would like to use but it is not available from the list (and you can't figure out how to build it yourself in your home directory), you may create a request using the issues tab (https://github.com/ai4d-iasc/trixie/issues) and please tag a member of Research Platform Support team (e.g., rloveNRC, nrcfieldsa, NRCGavin) to push a notification to the team. Please do not create duplicate requests for software (but feel free to comment on a thread to ''upvote'' the priority list is clear.

# Compilers

* gcc
* intel (not currently available, in procurement)

# Numerical libraries

* intel-mkl (not currently available, in procurement)

# Deep learning frameworks

* tensorflow
* pytorch

# Python

* system python
* CC stack python (now default):
  * [virtualenvs](jobs-python-virtualenv.md)
* Anaconda, miniconda:
  * System-wide Anaconda
  * User miniconda

# Scientific simulation software

* [abinit](jobs-abinit.md)
* lumerical
