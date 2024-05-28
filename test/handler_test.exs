defmodule HandlerTest do
  use ExUnit.Case

  import Servy.Handler, only: [handle: 1]

  test "GET /wildthings" do
    request = """
    GET /wildthings HTTPS/1.1\r
    Host: example.com\r
    User-Agent: ExampleBrowser/1.0\r
    Accept: */*\r
    \r
    """

    response = handle(request)

    assert response == """
    HTTP/1.1 200 OK\r
    Content-Type: text/html\r
    Content-Length: 20\r
    \r
    Bears, Lions, Tigers
    """
  end

  test "GET /bears" do
    request = """
    GET /bears HTTPS/1.1\r
    Host: example.com\r
    User-Agent: ExampleBrowser/1.0\r
    Accept: */*\r
    \r
    """

    response = handle(request)

    expected_response = """
    HTTP/1.1 200 OK\r
    Content-Type: text/html\r
    Content-Length: 367\r
    \r
    <h1>AllTheBears!</h1>

    <ul>
      <li>DarthVader-Sith</li>
      <li>LukeSkywalker-Jedi</li>
      <li>Yoda-Jedi</li>
      <li>Obi-Wan-Jedi</li>
      <li>Leia-Princesa</li>
      <li>HanSolo-Piloto</li>
      <li>Chewbacca-Copiloto</li>
      <li>C-3PO-Droide</li>
      <li>R2-D2-Droide</li>
      <li>BB-8-Droide</li>
    </ul>
    """

    assert remove_whitespace(response) == remove_whitespace(expected_response)
  end

  test "GET /bigfoot" do
    request = """
    GET /bigfoot HTTPS/1.1\r
    Host: example.com\r
    User-Agent: ExampleBrowser/1.0\r
    Accept: */*\r
    \r
    """

    response = handle(request)

    assert response == """
    HTTP/1.1 404 Not Found\r
    Content-Type: text/html\r
    Content-Length: 17\r
    \r
    No /bigfoot here!
    """
  end

  test "GET /bears/1" do
    request = """
    GET /bears/1 HTTPS/1.1\r
    Host: example.com\r
    User-Agent: ExampleBrowser/1.0\r
    Accept: */*\r
    \r
    """

    response = handle(request)

    expected_response = """
    HTTP/1.1 200 OK\r
    Content-Type: text/html\r
    Content-Length: 77\r
    \r
    <h1>ShowBear</h1>

    <p>
      IsDarthVaderhibernating?<strong>true</strong>
    </p>
    """

    assert remove_whitespace(response) == remove_whitespace(expected_response)
  end

  test "GET /wildlife" do
    request = """
    GET /wildlife HTTPS/1.1\r
    Host: example.com\r
    User-Agent: ExampleBrowser/1.0\r
    Accept: */*\r
    \r
    """

    response = handle(request)

    assert response == """
    HTTP/1.1 200 OK\r
    Content-Type: text/html\r
    Content-Length: 20\r
    \r
    Bears, Lions, Tigers
    """
  end

  test "GET /about" do
    request = """
    GET /about HTTPS/1.1\r
    Host: example.com\r
    User-Agent: ExampleBrowser/1.0\r
    Accept: */*\r
    \r
    """

    response = handle(request)

    expected_response = """
    HTTP/1.1 200 OK\r
    Content-Type: text/html\r
    Content-Length: 150\r
    \r
    <h1>LOSTINCANVAS</h1>
    <blockquote>
      Textoimagináriodoarquivoondenãopodemoscontextarnadarelacionadoescrito.--JohnGreen
    </blockquote>
    """

    assert remove_whitespace(response) == remove_whitespace(expected_response)
  end

  test "POST /bears" do
    request = """
    POST /bears HTTPS/1.1\r
    Host: example.com\r
    User-Agent: ExampleBrowser/1.0\r
    Accept: */*\r
    Content-Type: applicaion/x-www-form-urlencoded\r
    Content-Length: 21\r
    \r
    name=Baloo&type=Brown
    """

    response = handle(request)

    assert response == """
    HTTP/1.1 201 Created\r
    Content-Type: text/html\r
    Content-Length: 33\r
    \r
    Created a Brown bear named Baloo!
    """
  end

  test "GET /api/bears" do
    request = """
    GET /api/bears HTTPS/1.1\r
    Host: example.com\r
    User-Agent: ExampleBrowser/1.0\r
    Accept: */*\r
    \r
    """

    response = handle(request)

    expected_response = """
    HTTP/1.1 200 OK\r
    Content-Type: application/json\r
    Content-Length: 615\r
    \r
    [
      {"type": "Sith", "name": "DarthVader", "id": 1,"hibernating": true},
      {"type": "Jedi", "name": "Luke Skywalker", "id": 2,"hibernating": false},
      {"type": "Jedi", "name": "Yoda", "id": 3,"hibernating": false},
      {"type": "Jedi", "name": "Obi-Wan", "id": 4,"hibernating": true},
      {"type": "Princesa", "name": "Leia", "id": 5,"hibernating": false},
      {"type": "Piloto", "name": "Han Solo", "id": 6,"hibernating": false},
      {"type": "Copiloto", "name": "Chewbacca", "id": 7,"hibernating": true},
      {"type": "Droide", "name": "C-3PO", "id": 8,"hibernating": false},
      {"type": "Droide", "name": "R2-D2", "id": 9,"hibernating": true},
      {"type": "Droide", "name": "BB-8", "id": 10,"hibernating": false}
    ]
    """

    assert remove_whitespace(response) == remove_whitespace(expected_response)
  end

  defp remove_whitespace(text) do
    String.replace(text, ~r{\s}, "")
  end
end
