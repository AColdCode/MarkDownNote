#include <QApplication>
#include <QQmlApplicationEngine>
#include <QTranslator>

int main(int argc, char *argv[])
{
    QApplication app(argc, argv);

    QTranslator translator;
    translator.load(
        "/run/media/root/Study/Project/MarkDownNote/MarkDownNote/translations/zh_CN.qm");
    app.installTranslator(&translator);

    QQmlApplicationEngine engine;

    engine.loadFromModule("MarkDownNote", "MarkDownNote");

    return app.exec();
}
