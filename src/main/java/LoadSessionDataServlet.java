import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;

public class LoadSessionDataServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        resp.setContentType("text/html;charset=UTF-8");
        HttpSession session = req.getSession();
        PrintWriter printWriter = resp.getWriter();
        printWriter.println(generateTable(session));
        printWriter.close();
    }

    private String generateTable(HttpSession session) {
        String header = "<table id=\"resultTable\">" +
                "<tr class=\"table_header\">" +
                "<th class=\"coords_col\">X</th>" +
                "<th class=\"coords_col\">Y</th>" +
                "<th class=\"coords_col\">R</th>" +
                "<th class=\"time_col\">Current time</th>" +
                "<th class=\"time_col\">Execution time</th>" +
                "<th class=\"hitres_col\">Hit result</th>" +
                "</tr>%s</table>";
        ArrayList<String> table = (ArrayList<String>) session.getAttribute(session.getId());
        if (table == null) {
            table = new ArrayList<>();
        }
        StringBuilder rows = new StringBuilder();
        for (String row : table) {
            rows.append(row);
        }
        return String.format(header, rows);
    }
}