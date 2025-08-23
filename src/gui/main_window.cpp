/**
 * Canary - A free and open-source MMORPG server emulator
 * Copyright (©) 2019-2024 OpenTibiaBR <opentibiabr@outlook.com>
 * Repository: https://github.com/opentibiabr/canary
 * License: https://github.com/opentibiabr/canary/blob/main/LICENSE
 * Contributors: https://github.com/opentibiabr/canary/graphs/contributors
 * Website: https://docs.opentibiabr.com/
 */

#include "main_window.hpp"
#include "log_sink.hpp"

#include <QVBoxLayout>
#include <spdlog/spdlog.h>
#include "canary_server.hpp"
#include "lib/di/container.hpp"

MainWindow::MainWindow(QWidget* parent)
    : QMainWindow(parent)
{
    auto* central = new QWidget(this);
    auto* layout = new QVBoxLayout(central);
    startButton = new QPushButton(tr("Start Server"), this);
    stopButton = new QPushButton(tr("Stop Server"), this);
    stopButton->setEnabled(false);
    logWidget = new QPlainTextEdit(this);
    logWidget->setReadOnly(true);

    layout->addWidget(startButton);
    layout->addWidget(stopButton);
    layout->addWidget(logWidget);
    setCentralWidget(central);

    connect(startButton, &QPushButton::clicked, this, &MainWindow::startServer);
    connect(stopButton, &QPushButton::clicked, this, &MainWindow::stopServer);
}

MainWindow::~MainWindow() {
    stopServer();
}

void MainWindow::startServer() {
    if (running) {
        return;
    }
    running = true;
    startButton->setEnabled(false);
    stopButton->setEnabled(true);

    auto sink = std::make_shared<QtLogSink>(logWidget);
    spdlog::default_logger()->sinks().push_back(sink);

    serverThread = std::thread([]() {
        inject<CanaryServer>().run();
    });
}

void MainWindow::stopServer() {
    if (!running) {
        return;
    }
    running = false;
    startButton->setEnabled(true);
    stopButton->setEnabled(false);
    CanaryServer::shutdown();
    if (serverThread.joinable()) {
        serverThread.join();
    }
}
