#include <iostream>
#include <functional>
#include <sys/types.h>
#include <thread>
#include <vector>
#include <chrono>

#include "Demo.h"
#include "Timer.h"


int main()
{
    // std::cout << "Hello world!" << std::endl;
    Timer::getInstance()->init();
    Demo::getInstance()->func(2);
    while(1)
    {
        std::this_thread::sleep_for(std::chrono::seconds(1));
    }
}
