FROM java:8

RUN apt-get install -y \
    unzip \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*


WORKDIR /home
ADD http://nlp.stanford.edu/software/stanford-ner-2015-01-29.zip ner.zip
RUN unzip ner.zip

WORKDIR /home/stanford-ner-2015-01-30

RUN cp stanford-ner.jar stanford-ner-with-classifier.jar
RUN jar -uf stanford-ner-with-classifier.jar classifiers/english.all.3class.distsim.crf.ser.gz 

ENTRYPOINT exec java \
	-mx500m \
	-cp stanford-ner-with-classifier.jar edu.stanford.nlp.ie.NERServer \
	-port 9190 \
	-loadClassifier classifiers/english.all.3class.distsim.crf.ser.gz

EXPOSE 9190