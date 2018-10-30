#include <vector>
#include <iostream>

void heap_buffer_overflow()
{
    std::vector<int> v{1, 2, 3, 4, 5};
    v[5] = 0;
}

void memory_leak()
{
    void *p = malloc(7);
    p = 0;
}

int main()
{
    memory_leak();
    heap_buffer_overflow();

    std::cout << "Hello, World!\n";
    return 0;
}
