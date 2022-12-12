#include <stdio.h>
#include "udf_registration_types.h"


bool udf_buf_bug_init(UDF_INIT * initid, UDF_ARGS * args, char * message) {
    initid->max_length = 100;
    fprintf(stderr, "UDF: set max length to 100\n");
    return false;
}

char * udf_buf_bug(
    UDF_INIT * initid,
    UDF_ARGS * args,
    char * result,
    unsigned long * length,
    unsigned char * is_null,
    unsigned char * error)
{
    fprintf(stderr, "UDF: got result buffer of length %ld\n", *length);
    *length = 0;
    return 0;
}
