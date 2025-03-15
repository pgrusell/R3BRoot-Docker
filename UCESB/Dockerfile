FROM pablogrusell/fairroot:latest

WORKDIR /app/UCESB

RUN git clone https://git.chalmers.se/expsubphys/ucesb.git

WORKDIR /app/UCESB/ucesb 

RUN make empty

ENV UCESB_DIR=/app/UCESB/ucesb

CMD ["bash"]