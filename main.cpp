#include <QQmlApplicationEngine>
#include <QApplication>

int main(int argc, char *argv[])
{
    QApplication app(argc, argv);

    QQmlApplicationEngine engine;

    engine.loadFromModule("MarkDownNote", "MarkDownNote");

    return app.exec();
}
