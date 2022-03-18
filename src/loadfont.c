#include <stdio.h>
#include <string.h>
#include <stdlib.h>

char *loadFont(char *name)
{
  FILE *file;
  char *buffer;
  unsigned long fileLen;
  file = fopen(name, "rb");
  if (!file)
  {
    fprintf(stderr, "Unable to open file %s", name);
    return NULL;
  }
  fseek(file, 0, SEEK_END);
  fileLen = ftell(file);
  fseek(file, 0, SEEK_SET);
  buffer = (char *)malloc(fileLen+1);
  if (!buffer)
  {
    fprintf(stderr, "Memory error!");
    fclose(file);
    return NULL;
  }
  fread(buffer, fileLen, 1, file);
  fclose(file);
  return buffer;
}

void freeFont(void *font)
{
  free(font);
}

