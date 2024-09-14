<?php
class database
{
  private $host = "localhost";
  private $username = "root";
  private $password = "";
  private $database = "PWEB2";
  private $koneksi;

  function __construct()
  {
    $this->koneksi = mysqli_connect($this->host, $this->username, $this->password, $this->database);
    if (mysqli_connect_errno()) {
      die("koneksi database gagal: " . mysqli_connect_error());
    }
  }
  protected function query($sql)
  {
    return mysqli_query($this->koneksi, $sql);
  }
  function tampil() {}
}
