
FROM ubuntu:22.04

WORKDIR /app/FAIRSOFT

COPY setup-ubuntu.sh .
RUN chmod +x setup-ubuntu.sh && ./setup-ubuntu.sh

RUN git clone -b nov22p4 https://github.com/FairRootGroup/FairSoft.git

WORKDIR /app/FAIRSOFT/build

RUN cmake -S ../FairSoft -B . -C ../FairSoft/FairSoftConfig.cmake
RUN cmake --build .

ENV SIMPATH=/app/FAIRSOFT/FairSoft/install

CMD ["bash"]