#ifndef AUDIOLEVELS_H
#define AUDIOLEVELS_H

#include <QAudioInput>
#include <QBuffer>
#include <QTimer>

class AudioLevels : public QAudioInput
{
    Q_OBJECT
    Q_PROPERTY(int inputLevel READ inputLevel WRITE setInputLevel NOTIFY inputLevelChanged)

public:
    explicit AudioLevels(QObject *parent = nullptr);

    int inputLevel() const { return m_inputLevel; }
    void setInputLevel(int newLevel);

signals:
    void inputLevelChanged();

private:
    int m_inputLevel;
    QBuffer m_buf;
    QTimer m_updateTimer;
};

#endif // AUDIOLEVELS_H
