FROM node:12.19-slim

ENV USER=swiftmill

# install python and make
RUN apt-get update && \
	apt-get install -y python3 build-essential && \
	apt-get purge -y --auto-remove
	
# create swiftmill user
RUN groupadd -r ${USER} && \
	useradd --create-home --home /home/swiftmill -r -g ${USER} ${USER}
	
# set up volume and user
USER ${USER}
WORKDIR /home/swiftmill

COPY package*.json ./
RUN npm install
VOLUME [ "/home/swiftmill" ]

COPY . .

ENTRYPOINT [ "node", "index.js" ]
