#include "readthread.h"

ReadThread::ReadThread(QObject *parent) : QObject(parent)
{
    reader.moveToThread(&pThread);

    connect(&pThread, &QThread::started, &reader, &FileReader::invokeMainReadMethod);
    connect(&reader, &FileReader::readingFinished, &pThread, &QThread::quit);
    connect(&reader, &FileReader::addToModel, this, &ReadThread::addToModel); // signal to signal
    connect(&reader, &FileReader::readingFinished, this, &ReadThread::readFinished); // signal to signal

    pThread.start();
}

ReadThread::~ReadThread()
{
    qDebug()<<"read thread destructor";
}
