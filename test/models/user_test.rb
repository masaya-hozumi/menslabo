require 'test_helper'

class UserTest < ActiveSupport::TestCase

  def setup
    @user = User.new(name: "Example User", email: "user@example.com",
              password: "foobar", password_confirmation: "foobar")
  end

  test "有効性のテスト" do
    assert @user.valid?
  end

  test "空白の名前に対するテスト" do
    @user.name = "     "
    assert_not @user.valid?
  end

  test "空白のメールアドレスに対するテスト" do
    @user.email = "     "
    assert_not @user.valid?
  end

  test "名前の長さに対するテスト" do
    @user.name = "a" * 51
    assert_not @user.valid?
  end

  test "メールアドレスの長さに対するテスト" do
    @user.email = "a" * 244 + "@example.com"
    assert_not @user.valid?
  end

  test "有効なメールアドレスに対してテスト" do
    valid_addresses = %w[user@example.com USER@foo.COM A_US-ER@foo.bar.org
                          first.last@foo.jp alice+bob@baz.cn]
    valid_addresses.each do |valid_address|
      @user.email = valid_address
      assert @user.valid?, "#{valid_address.inspect} should be valid"
    end
  end

  test "無効なメールアドレスに対するテスト" do
    invalid_addresses = %w[user@example,com user_at_foo.org user.name@example.
                            foo@bar_baz.com foo@bar+baz.com foo@bar..com]
    invalid_addresses.each do |invalid_address|
      @user.email = invalid_address
      assert_not @user.valid?, "#{invalid_address.inspect} should be invalid"
    end
  end

  test "重複するメールアドレスを拒否するテスト" do
    duplicate_user = @user.dup
    @user.save
    assert_not duplicate_user.valid?
  end

  test "小文字化に対するテスト" do
    mixed_case_email = "Foo@ExAMPle.CoM"
    @user.email = mixed_case_email
    @user.save
    assert_equal mixed_case_email.downcase, @user.reload.email
  end

  test "空白のパスワードに対するテスト" do
    @user.password = @user.password_confirmation = " " * 6
    assert_not @user.valid?
  end

  test "パスワードの長さが6文字以上であることのテスト" do
    @user.password = @user.password_confirmation = "a" * 5
    assert_not @user.valid?
  end

  test "authenticated? should return false for a user with nil digest" do
    assert_not @user.authenticated?(:remember, '')
  end
end
