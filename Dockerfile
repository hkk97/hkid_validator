# Stage 1
FROM nginx:stable-alpine as stage1

# System software upgrade and install, then remove unnecessary layes to reduce docker image size
RUN apt-get update &&  apt-get --no-install-recommends -y unzip git && apt-get upgrade -y && apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* /var/cache/apt

# Install Flutter
RUN git clone https://github.com/flutter/flutter.git /usr/local/flutter 
ENV PATH="/usr/local/flutter/bin:/usr/local/flutter/bin/cache/dart-sdk/bin:${PATH}"
RUN flutter channel stable 
RUN flutter upgrade
RUN flutter config --enable-web 
RUN flutter config --no-analytics
RUN flutter doctor -v 

# Copy files to container and get dependencies
COPY . /usr/local/bin/app/
WORKDIR /usr/local/bin/app/example
RUN flutter pub get
RUN flutter build web --web-renderer html --no-sound-null-safety --dart-define=ENV=PROD -dart-define=FLUTTER_WEB_USE_SKIA=true --release

# Stage 2
FROM nginx:stable-alpine
WORKDIR /usr/share/nginx
COPY --from=stage1 /usr/local/bin/app/example/build/web /var/www/wchklaus.xyz/hkidvalidator
COPY --from=stage1 /usr/local/bin/app/example/assets/demo /var/www/wchklaus.xyz/hkidvalidator/assets/assets/demo

COPY example/nginx/default.conf /etc/nginx/conf.d/default.conf
COPY example/nginx/nginx.conf /etc/nginx/nginx.conf
EXPOSE 8080