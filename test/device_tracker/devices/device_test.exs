defmodule DeviceTracker.Devices.DeviceTest do
  use ExUnit.Case, async: true

  alias DeviceTracker.Devices.Device

  describe "add_device/2" do
    test "allows us to register a device" do
      name = "lightbulb"
      measurement = "power_used"

      assert {:ok, %{measurements: ["power_used"], name: "lightbulb"}} =
               Device.add_device(name, [measurement])

      assert Registry.count(DeviceTracker.Registry) == 1

      assert DynamicSupervisor.count_children(DeviceTracker.DynamicSupervisor) == %{
               active: 1,
               specs: 1,
               supervisors: 0,
               workers: 1
             }
    end
  end

  describe "add_measurement/3" do
    test "Allows us to add measurements" do
      name = "lightbulb2"
      measurement = "power_used"
      Device.add_device(name, [measurement])

      assert Device.get_measurements(name, measurement) == []

      assert Device.add_measurement(name, measurement, 1) ==
               {:ok, %{measurement: "power_used", measurements: [1]}}

      assert Device.add_measurement(name, measurement, 2) ==
               {:ok, %{measurement: "power_used", measurements: [2, 1]}}

      assert Device.get_measurements(name, measurement) == [2, 1]
    end
  end

  describe "get_measurements/2" do
    @tag :skip
    test "gets measurements for a given device" do
    end
  end

  describe "get/1" do
    @tag :skip
    test "gets all information for the given device" do
    end
  end

  describe "list_all/0" do
    @tag :skip
    test "lists all information for all devices" do
    end
  end

  describe "update/2" do
    @tag :skip
    test "updates settings for the given device" do
    end
  end

  describe "delete/1" do
    @tag :skip
    test "deletes the given device" do
    end
  end
end
