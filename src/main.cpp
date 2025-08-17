/**
 * Canary - A free and open-source MMORPG server emulator
 * Copyright (©) 2019-2024 OpenTibiaBR <opentibiabr@outlook.com>
 * Repository: https://github.com/opentibiabr/canary
 * License: https://github.com/opentibiabr/canary/blob/main/LICENSE
 * Contributors: https://github.com/opentibiabr/canary/graphs/contributors
 * Website: https://docs.opentibiabr.com/
 */

#include "canary_server.hpp"
#include "lib/di/container.hpp"
#include <thread>

int main() {
	int code;
	do {
		code = inject<CanaryServer>().run();
		if (code == CanaryServer::RESTART_CODE) {
			std::this_thread::sleep_for(std::chrono::seconds(5));
		}
	} while (code == CanaryServer::RESTART_CODE);
	return code;
}
