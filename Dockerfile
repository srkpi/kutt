# specify node.js image
FROM node:22-alpine

# use production node environment by default
ENV NODE_ENV=production

# set working directory.
WORKDIR /kutt

# copy package.json and package-lock.json
COPY package.json package-lock.json ./

# download dependencies while using Docker's caching
RUN --mount=type=cache,id=s/1f6eb2da-ed43-4591-965b-cbcdc0e8ccf0-/root/.npm,target=/root/.npm \
    npm ci --omit=dev

RUN mkdir -p /var/lib/kutt

# copy the rest of source files into the image
COPY . .

# expose the port that the app listens on
EXPOSE 3000

# intialize database and run the app
CMD npm run migrate && npm start
