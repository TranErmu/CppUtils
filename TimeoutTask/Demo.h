#ifndef __DEMO_H__
#define __DEMO_H__

class Demo
{
    explicit Demo() = default;
    virtual ~Demo() = default;
    Demo(const Demo&) = delete;
    Demo &operator=(const Demo&) = delete;
public:
    static Demo * getInstance();

    void func(int idx);

    void setIdx(int idx);
    void showIdx();

  private:
    int m_index = -1;
};

#endif