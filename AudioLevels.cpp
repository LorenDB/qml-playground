#include "AudioLevels.h"
#include <QBuffer>
#include <QDebug>

AudioLevels::AudioLevels(QObject *parent) : QAudioInput(QAudioFormat{}, parent)
{
    start(&m_buf);
    m_updateTimer.setInterval(100);
    m_updateTimer.setSingleShot(false);
    connect(&m_updateTimer, &QTimer::timeout, this, [this]() {
        this->start(&m_buf);
        if (m_buf.size() > 0)
        {
            setInputLevel(m_buf.buffer().back());
            if (m_buf.data().size() > 2048)
            {
                auto data = m_buf.data();
                data.resize(10);
                m_buf.setData(data);
            }
        }
    });
    m_updateTimer.start();
}
