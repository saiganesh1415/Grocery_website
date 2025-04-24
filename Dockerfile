FROM nginx:alpine
COPY Grocerywebsite.github.io-master /usr/share/nginx/html
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]


