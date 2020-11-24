#include "iostream"
using namespace std;

int main(){
    float a=1.1;
    float b;
    *(int*)&b=0x3f8ccccd;
    printf("in binary, %x\n",*(int*)&a);
    printf("in float, %f\n",b);
return 0;
}