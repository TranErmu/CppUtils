#ifndef __TIMER_H__
#define __TIMER_H__

#include <vector>
#include <thread>
#include <functional>

#define DEMO_DELAY_TIME (5u)

typedef std::function<int(void)> StandardTask;

class Timer
{
    explicit Timer() = default;
    virtual ~Timer() = default;
    Timer(const Timer&) = delete;
    Timer &operator=(const Timer&) = delete;
public:
    static Timer * getInstance();

    void init();
    
    void registerTimerTask(StandardTask task);

    void timerThread();

private:
    std::thread m_th;
    std::vector<StandardTask> m_timer_task_lists;
};

#endif