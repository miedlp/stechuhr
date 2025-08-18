// Copyright (c) 2025 Philipp Miedl
//
// SPDX-License-Identifier: EUPL-1.2

use std::time::Duration;
use std::cmp::Ordering;

#[flutter_rust_bridge::frb(sync)] // Synchronous mode for simplicity of the demo
pub fn format_duration(duration_in_minutes: i64) -> String {

    let negative_sign;
    let duration;
    match duration_in_minutes.cmp(&0) {
        Ordering::Less => {
            // Negative duration
            negative_sign = format!("-");
            duration = Duration::from_secs(-duration_in_minutes as u64 * 60);
        },
        Ordering::Equal => {
            // Positive duration
            negative_sign = format!("");
            duration = Duration::from_secs(duration_in_minutes as u64 * 60);
        },
        Ordering::Greater => {
            // Positive duration
            negative_sign = format!("");
            duration = Duration::from_secs(duration_in_minutes as u64* 60);
        },
    }

    let in_seconds = duration.as_secs();
    let in_minutes = (in_seconds - (in_seconds % 60)) / 60;
    let hours = (in_minutes - (in_minutes % 60)) / 60;
    let minutes = in_minutes - (hours * 60);

    format!("{negative_sign}{hours:0>2}:{minutes:0>2}")
}

#[flutter_rust_bridge::frb(init)]
pub fn init_app() {
    // Default utilities - feel free to customize
    flutter_rust_bridge::setup_default_user_utils();
}

#[cfg(test)]
mod tests {
    use super::format_duration;
    use std::time::Duration;

    #[test]
    fn test_format_duration_zero() {
        assert_eq!(format_duration(0), "00:00");
    }

    #[test]
    fn test_format_duration_negative_minutes_only() {
        assert_eq!(format_duration(-45), "-00:45");
    }

    #[test]
    fn test_format_duration_negative_hours_minutes() {
        assert_eq!(format_duration(-125), "-02:05");
    }

    #[test]
    fn test_format_duration_negative_doubledigithours_minutes() {
        assert_eq!(format_duration(-3661), "-61:01");
    }

    #[test]
    fn test_format_duration_negative_large_value() {
        assert_eq!(format_duration(-86399), "-1439:59");
    }

    #[test]
    fn test_format_duration_minutes_only() {
        assert_eq!(format_duration(45), "00:45");
    }

    #[test]
    fn test_format_duration_hours_minutes() {
        assert_eq!(format_duration(125), "02:05");
    }

    #[test]
    fn test_format_duration_doubledigithours_minutes() {
        assert_eq!(format_duration(3661), "61:01");
    }

    #[test]
    fn test_format_duration_large_value() {
        assert_eq!(format_duration(86399), "1439:59");
    }

    #[test]
    fn test_format_danish_minus_austrian_workday() {
        let danish = Duration::new(37 * 3600 / 5, 0);
        let austrian = Duration::new(40 * 3600 / 5, 0);
        let difference = (austrian - danish).as_secs() as i64 / -60;
        assert_eq!(format_duration(difference as i64), "-00:36");
    }
}