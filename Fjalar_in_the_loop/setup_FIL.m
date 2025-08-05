
setup;

pyenv();
pypath = mfilename('fullpath');
pypath = erase(pypath, mfilename());
py.sys.path().append(pypath);
protobuf_not_installed = system(pyenv().Executable +' -m pip show protobuf');
if protobuf_not_installed; system(pyenv().Executable +' -m pip install protobuf'); end



