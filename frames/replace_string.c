#include <stdio.h>
#include <stdlib.h>
#include <string.h>

void replaceHref(FILE *infile, FILE *outfile) {
    char line[4096];
    const char *pattern_start = "<a HREF=\"../docs/";
    const char *replacement_start = "<a href=\"javascript:void(0);\" onclick=\"checkPassword('";
    const char *replacement_mid = "../docs/";
    const char *replacement_end = "');\">";

    while (fgets(line, sizeof(line), infile)) {
        char *found = strcasestr(line, pattern_start);

        printf("%s\n", line);

        while (found) {
            // Write up to the found pattern to the outfile
            *found = '\0';
            fprintf(outfile, "%s%s%s", line, replacement_start, replacement_mid);

            // Skip the pattern
            found += strlen(pattern_start);

            // Write the remaining URL to outfile
            char *endquote = strchr(found, '"');
            if (endquote) {
                *endquote = '\0';
                fprintf(outfile, "%s%s", found, replacement_end);
                strcpy(line, endquote + 2); // +2 to also skip the ending '>'
            } else {
                // Unexpected format, just print the remaining line
                fprintf(outfile, "%s", found);
                line[0] = '\0';
            }

            found = strstr(line, pattern_start);
        }

        // Print the rest of the line
        fprintf(outfile, "%s", line);
    }
}

int main(int argc, char *argv[]) {
    if (argc < 3) {
        printf("Usage: %s <input_html_file> <output_html_file>\n", argv[0]);
        return 1;
    }

    FILE *infile = fopen(argv[1], "r");
    FILE *outfile = fopen(argv[2], "w");

    if (!infile || !outfile) {
        perror("Error opening file");
        return 1;
    }

    replaceHref(infile, outfile);

    fclose(infile);
    fclose(outfile);

    return 0;
}
