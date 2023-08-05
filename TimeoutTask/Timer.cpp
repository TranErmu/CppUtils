#include <cstdio>
#include "Timer.h"
#include "Demo.h"

Timer *Timer::getInstance() 
{
  static Timer instance;
  return &instance;
}

void Timer::init()
{
    m_th = std::thread(&Timer::timerThread, this);
}

void Timer::registerTimerTask(StandardTask task)
{
    m_timer_task_lists.emplace_back(std::move(task));
}

void Timer::timerThread()
{
    while (1) {
        if (m_timer_task_lists.size() > 0) 
        {
            for(auto iter = m_timer_task_lists.begin(); iter != m_timer_task_lists.end();)
            {
                if ((*iter)() == 0)
                {
                    iter = m_timer_task_lists.erase(iter);
                }
                else 
                {
                    ++iter;
                }
            }
        }
        else 
        {
            Demo::getInstance()->showIdx();
            printf("no task\n");
        }
        std::this_thread::sleep_for(std::chrono::seconds(DEMO_DELAY_TIME));
    }
}