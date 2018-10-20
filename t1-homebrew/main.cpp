#include <folly/container/Array.h>
//#include <folly/portability/GTest.h>
#include <string>
#include <iostream>

// the example is from folly/folly/container/test/ArrayTest.cpp

int main()
{
    auto arr = folly::make_array<int>(1, 2, 3);
    static_assert(std::is_same<typename decltype(arr)::value_type, int>::value, "Wrong array type");
    //EXPECT_EQ(arr.size(), 0);
    std::cout << arr.size() << std::endl;
}
