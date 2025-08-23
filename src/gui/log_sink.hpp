/**
 * Canary - A free and open-source MMORPG server emulator
 * Copyright (©) 2019-2024 OpenTibiaBR <opentibiabr@outlook.com>
 * Repository: https://github.com/opentibiabr/canary
 * License: https://github.com/opentibiabr/canary/blob/main/LICENSE
 * Contributors: https://github.com/opentibiabr/canary/graphs/contributors
 * Website: https://docs.opentibiabr.com/
 */

#pragma once

#include <spdlog/sinks/base_sink.h>
#include <QPlainTextEdit>
#include <QMetaObject>
#include <fmt/format.h>
#include <mutex>

class QtLogSink : public spdlog::sinks::base_sink_mt {
public:
    explicit QtLogSink(QPlainTextEdit* widget) : widget_(widget) {}

protected:
    void sink_it_(const spdlog::details::log_msg& msg) override {
        spdlog::memory_buf_t formatted;
        base_sink_mt::formatter_->format(msg, formatted);
        auto text = fmt::to_string(formatted);
        QMetaObject::invokeMethod(widget_, [w = widget_, text]() {
            w->appendPlainText(QString::fromStdString(text));
        }, Qt::QueuedConnection);
    }

    void flush_() override {}

private:
    QPlainTextEdit* widget_;
};
