#include <cstdio>
#include "Demo.h"
#include "Timer.h"

Demo * Demo::getInstance()
{
    static Demo instance;
    return &instance;
}

void Demo::func(int idx)
{
    StandardTask task = [&, idx]() mutable -> int {
        --idx;
        if (idx > 0)
        {
            printf("idx = %d\n", idx);
        }
        else 
        {
            m_index = 10;
        }
        return idx;
    };
    Timer::getInstance()->registerTimerTask(std::move(task));
}

void Demo::setIdx(int idx)
{
    m_index = idx;
}

void Demo::showIdx() 
{
    printf("m_index = %d\n", m_index);
}