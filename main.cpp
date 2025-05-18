#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>
#include <QtWebEngineQuick>
#include "markdownconverter.h"

int main(int argc, char *argv[])
{
    QtWebEngineQuick::initialize();

    QGuiApplication app(argc, argv);

    QQmlApplicationEngine engine;

    engine.loadFromModule("MarkDownNote", "MarkDownNote");

    return app.exec();
}
