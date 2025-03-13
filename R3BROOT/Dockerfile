FROM fairroot_image

WORKDIR /app/R3BROOT

RUN git clone https://github.com/R3BRootGroup/R3BRoot.git
WORKDIR /app/R3BROOT/R3BRoot 
RUN git clone https://github.com/R3BRootGroup/macros.git

WORKDIR /app/R3BROOT/build

RUN cmake -S ../R3BRoot -B .
RUN cmake --build . 
RUN source config.sh

CMD ["bash"]