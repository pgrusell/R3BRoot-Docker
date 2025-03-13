FROM fairsoft_image

WORKDIR /app/FAIRROOT

RUN git clone -b dev https://github.com/FairRootGroup/FairRoot.git

WORKDIR /app/FAIRROOT/build

RUN cmake ../FairRoot -DCMAKE_INSTALL_PREFIX="../FairRoot/install" ..
RUN make 
RUN make install

ENV FAIRROOTPATH=/app/FAIRROOT/FairRoot/install

CMD ["bash"]