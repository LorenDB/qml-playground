#include "AudioLevels.h"
#include <QBuffer>
#include <QDebug>

QAudioFormat getFormat();

AudioLevels::AudioLevels(QObject *parent)
    : QAudioInput(getFormat(), parent)
{
    m_buf.open(QIODevice::ReadWrite);

    start(&m_buf);
    m_updateTimer.setInterval(100);
    m_updateTimer.setSingleShot(false);
    connect(&m_updateTimer, &QTimer::timeout, this, [this]() {
        if (m_buf.size() > 0)
        {
            setInputLevel(m_buf.buffer().back());
            if (m_buf.data().size() > 2048)
            {
                m_buf.reset();
            }
        }
    });
    m_updateTimer.start();
}

void AudioLevels::setInputLevel(int newLevel)
{
    if (m_inputLevel == newLevel) return;
    m_inputLevel = newLevel;
    emit inputLevelChanged();
}

QAudioFormat getFormat()
{
    QAudioFormat format;
    format.setSampleRate(8000);
    format.setChannelCount(1);
    format.setSampleSize(8);
    format.setCodec("audio/pcm");
    format.setByteOrder(QAudioFormat::LittleEndian);
    format.setSampleType(QAudioFormat::UnSignedInt);

    return format;
}
