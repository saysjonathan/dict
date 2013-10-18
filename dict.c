#import <errno.h>
#import <CoreFoundation/CoreFoundation.h>
#import <CoreServices/CoreServices.h>

static void usage() {
	printf("usage: dict [word]\n");
	exit(EXIT_FAILURE);
}

static char * copyCFString(CFStringRef string) {
	if(string == NULL) {
		return NULL;
	}

	CFIndex length = CFStringGetLength(string);
	CFIndex maxSize = CFStringGetMaximumSizeForEncoding(length, kCFStringEncodingUTF8);
	char *buffer = (char *)malloc(maxSize);

	if (CFStringGetCString(string, buffer, maxSize, kCFStringEncodingUTF8)) {
		return buffer;
	}
	return NULL;
}

int main(int argc, char *argv[]) {
	if (argc <= 1 || (argc == 2 && argv[1][0] == '-' && argv[1][1] == 'h')) usage();

	for(int i = 1; i < argc; i++) {
		CFStringRef searchPhrase = CFStringCreateWithCString(NULL, argv[i], kCFStringEncodingUTF8);
		if(searchPhrase) {
			CFRange searchRange = DCSGetTermRangeInString(NULL, searchPhrase, 0);
			CFStringRef definition = DCSCopyTextDefinition(NULL, searchPhrase, searchRange);
			if(definition) {
				char *def = copyCFString(definition);
				printf("%s\n\n", def);
				CFRelease(definition);
			} else {
				printf("no definition found for %s\n\n", argv[i]);
			}
			CFRelease(searchPhrase);
		}
	}

	return 0;
}
