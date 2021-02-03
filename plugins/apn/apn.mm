/*************************************************************************/
/*  apn.mm                                                               */
/*************************************************************************/
/*                       This file is part of:                           */
/*                           GODOT ENGINE                                */
/*                      https://godotengine.org                          */
/*************************************************************************/
/* Copyright (c) 2007-2021 Juan Linietsky, Ariel Manzur.                 */
/* Copyright (c) 2014-2021 Godot Engine contributors (cf. AUTHORS.md).   */
/*                                                                       */
/* Permission is hereby granted, free of charge, to any person obtaining */
/* a copy of this software and associated documentation files (the       */
/* "Software"), to deal in the Software without restriction, including   */
/* without limitation the rights to use, copy, modify, merge, publish,   */
/* distribute, sublicense, and/or sell copies of the Software, and to    */
/* permit persons to whom the Software is furnished to do so, subject to */
/* the following conditions:                                             */
/*                                                                       */
/* The above copyright notice and this permission notice shall be        */
/* included in all copies or substantial portions of the Software.       */
/*                                                                       */
/* THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,       */
/* EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF    */
/* MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.*/
/* IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY  */
/* CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT,  */
/* TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE     */
/* SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.                */
/*************************************************************************/

#include "apn.h"

#import <Foundation/Foundation.h>

#include "core/class_db.h"
#include "core/project_settings.h"

#import "apn_implementation.h"

static APNPlugin *singleton;

APNPlugin *APNPlugin::get_singleton() {
	return singleton;
}

void APNPlugin::_bind_methods() {
	ClassDB::bind_method(D_METHOD("register_push_notifications", "options"), &APNPlugin::register_push_notifications);

	ADD_SIGNAL(MethodInfo("device_address_changed", PropertyInfo(Variant::STRING, "id")));

	BIND_ENUM_CONSTANT(PUSH_ALERT);
	BIND_ENUM_CONSTANT(PUSH_BADGE);
	BIND_ENUM_CONSTANT(PUSH_SOUND);
}

void APNPlugin::register_push_notifications(PushOptions options) {
	UNAuthorizationOptions notificationsOptions = 0;

	if (options & PUSH_ALERT) {
		notificationsOptions |= UNAuthorizationOptionAlert;
	}

	if (options & PUSH_BADGE) {
		notificationsOptions |= UNAuthorizationOptionBadge;
	}

	if (options & PUSH_SOUND) {
		notificationsOptions |= UNAuthorizationOptionSound;
	}

	[[GodotAPNAppDelegate shared] registerPushNotificationsWithOptions:options];
}

void APNPlugin::update_device_token(String token) {
	emit_signal("device_address_changed", token);
}

APNPlugin::APNPlugin() {
	singleton = this;
}

APNPlugin::~APNPlugin() {
	singleton = NULL;
}
