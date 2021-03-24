#include <unistd.h>

static const char prompt[] = "Welcome! Please enter a name: ";
static const char goodLuck[] = "Good luck, ";

int main() {
    
    char buf[256];
    
    write(1, prompt, 30);
    write(1, "\n", 1);
    int nameSize = read(0, buf, 256);
    write(1, goodLuck, 11);
    write(1, buf, nameSize);
}