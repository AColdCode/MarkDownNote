#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>
#include <QtWebEngineQuick>
#include "markdownconverter.h"

int main(int argc, char *argv[]) {
    QtWebEngineQuick::initialize();

    QGuiApplication app(argc, argv);

    QQmlApplicationEngine engine;

    MarkdownConverter converter;
    engine.rootContext()->setContextProperty("markdownConverter", &converter);

    engine.loadFromModule("MarkDownNote", "Main");

    return app.exec();
}
