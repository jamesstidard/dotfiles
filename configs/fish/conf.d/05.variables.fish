if status is-login
    set --global --export EDITOR code
    
    set --global --export CPPFLAGS "-I"(brew --prefix zlib)"/include -I"(brew --prefix sqlite)"/include -I"(brew --prefix bzip2)"/include"
    set --global --export LDFLAGS "-L"(brew --prefix zlib)"/lib -L"(brew --prefix sqlite)"/lib -L"(brew --prefix bzip2)"/lib"
end
