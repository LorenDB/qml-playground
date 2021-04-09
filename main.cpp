#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include "AudioLevels.h"
#include <QColor>
#include <QDebug>

int main(int argc, char *argv[])
{
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);

    QGuiApplication app(argc, argv);
//    QStringList colorNames = QColor::colorNames();
//    for (auto i : colorNames)
//        qDebug() << i;

//    static AudioLevels al;

//    qmlRegisterSingletonType<AudioLevels>("confetti", 1, 0, "AudioLevels", [](QQmlEngine *, QJSEngine *) -> QObject * {
//        return &al;
//    });
    qmlRegisterType<AudioLevels>("confetti", 1, 0, "AudioLevels");

    QQmlApplicationEngine engine;
    const QUrl url(QStringLiteral("qrc:/main.qml"));
    QObject::connect(&engine, &QQmlApplicationEngine::objectCreated,
                     &app, [url](QObject *obj, const QUrl &objUrl) {
        if (!obj && url == objUrl)
            QCoreApplication::exit(-1);
    }, Qt::QueuedConnection);
    engine.load(url);

    return app.exec();
}
