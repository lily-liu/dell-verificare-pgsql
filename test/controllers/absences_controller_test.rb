require 'test_helper'

class AbsencesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @absence = absences(:one)
  end

  test "should get index" do
    get absences_url, as: :json
    assert_response :success
  end

  test "should create absence" do
    assert_difference('Absence.count') do
      post absences_url, params: { absence: {  } }, as: :json
    end

    assert_response 201
  end

  test "should show absence" do
    get absence_url(@absence), as: :json
    assert_response :success
  end

  test "should update absence" do
    patch absence_url(@absence), params: { absence: {  } }, as: :json
    assert_response 200
  end

  test "should destroy absence" do
    assert_difference('Absence.count', -1) do
      delete absence_url(@absence), as: :json
    end

    assert_response 204
  end
end
