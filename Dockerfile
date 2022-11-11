FROM purplekarrot/mingw-w64-x86-64

ENV VCPKG_ROOT=/vcpkg

RUN apt update && apt install build-essential git curl zip unzip tar pkg-config xxd python3 nasm -y
RUN curl https://packages.microsoft.com/keys/microsoft.asc | apt-key add -
RUN sh -c 'echo "deb [arch=amd64] https://packages.microsoft.com/repos/microsoft-debian-bullseye-prod bullseye main" > /etc/apt/sources.list.d/microsoft.list'
RUN apt update && apt install powershell -y

RUN git clone https://github.com/bluesadi/Pluto-Obfuscator && cd Pluto-Obfuscator && git reset --hard a9d03fea2e714ba2bddf2d60adaf87392b08adb5 && cmake -G "Ninja" -DLLVM_ENABLE_PROJECTS="clang" -DCMAKE_BUILD_TYPE=Release -DLLVM_TARGETS_TO_BUILD="X86" -DBUILD_SHARED_LIBS=On ./llvm && ninja && ninja install && cd .. && rm -rf Pluto-Obfuscator
RUN git clone https://github.com/tpoechtrager/wclang && cd wclang && cmake -DCMAKE_INSTALL_PREFIX=/usr/local . && make && make install && cd .. && rm -rf wclang
