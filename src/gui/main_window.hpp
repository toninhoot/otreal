/**
 * Canary - A free and open-source MMORPG server emulator
 * Copyright (©) 2019-2024 OpenTibiaBR <opentibiabr@outlook.com>
 * Repository: https://github.com/opentibiabr/canary
 * License: https://github.com/opentibiabr/canary/blob/main/LICENSE
 * Contributors: https://github.com/opentibiabr/canary/graphs/contributors
 * Website: https://docs.opentibiabr.com/
 */

#pragma once

#include <QMainWindow>
#include <QPushButton>
#include <QPlainTextEdit>
#include <thread>
#include <memory>

class MainWindow : public QMainWindow {
    Q_OBJECT
public:
    explicit MainWindow(QWidget* parent = nullptr);
    ~MainWindow() override;

private slots:
    void startServer();
    void stopServer();

private:
    QPushButton* startButton;
    QPushButton* stopButton;
    QPlainTextEdit* logWidget;
    std::thread serverThread;
    bool running = false;
};
