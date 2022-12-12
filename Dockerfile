# ```
# # Build the image
# docker build . --tag mdb-udf-bug
#
# # Run the container
# docker run --rm -e MARIADB_ROOT_PASSWORD=example --name mdb-udf-bug-c mdb-udf-bug
#
# # Enter a SQL console
# docker exec -it mdb-udf-bug-c mysql -pexample
# 
# # Load function
# CREATE FUNCTION udf_buf_bug RETURNS string SONAME 'udf_bug.so';
# select udf_buf_bug();
# select hex(udf_buf_bug()); -- could be any function
# ```

FROM gcc:latest AS build

WORKDIR /build

COPY . .

RUN gcc -shared -fPIC udf_bug.c -o udf_bug.so \
    && mkdir /output \
    && cp udf_bug.so /output

FROM mariadb:10.10

COPY --from=build /output/* /usr/lib/mysql/plugin/
