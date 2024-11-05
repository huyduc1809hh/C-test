document.addEventListener('DOMContentLoaded', function () {
    displayBudgets();
});

document.getElementById('budgetForm').addEventListener('submit', function (e) {
    e.preventDefault();
    addOrUpdateBudget();
});

function displayBudgets() {
    const budgetTableBody = document.getElementById('budgetTableBody');
    budgetTableBody.innerHTML = '';
    const budgets = JSON.parse(localStorage.getItem('budgets')) || [];

    budgets.forEach(budget => {
        const row = document.createElement('tr');
        row.innerHTML = `
            <td class="border p-2">${budget.nganSachID}</td>
            <td class="border p-2">${budget.duAnID}</td>
            <td class="border p-2">${budget.soTien}</td>
            <td class="border p-2">${budget.moTa}</td>
            <td class="border p-2">${budget.ngayCapNhat}</td>
            <td class="border p-2">
                <button onclick="editBudget(${budget.nganSachID})" class="text-blue-500">Sửa</button>
                <button onclick="deleteBudget(${budget.nganSachID})" class="text-red-500">Xóa</button>
            </td>
        `;
        budgetTableBody.appendChild(row);
    });
}

function addOrUpdateBudget() {
    const nganSachID = parseInt(document.getElementById('nganSachID').value);
    const duAnID = parseInt(document.getElementById('duAnID').value);
    const soTien = parseFloat(document.getElementById('soTien').value);
    const moTa = document.getElementById('moTa').value;
    const ngayCapNhat = document.getElementById('ngayCapNhat').value;

    let budgets = JSON.parse(localStorage.getItem('budgets')) || [];

    const existingBudget = budgets.find(budget => budget.nganSachID === nganSachID);
    if (existingBudget) {
        alert('ID Ngân Sách đã tồn tại!');
        return;
    }

    budgets.push({ nganSachID, duAnID, soTien, moTa, ngayCapNhat });
    localStorage.setItem('budgets', JSON.stringify(budgets));

    displayBudgets();
    document.getElementById('budgetForm').reset();
}

function deleteBudget(nganSachID) {
    let budgets = JSON.parse(localStorage.getItem('budgets')) || [];
    budgets = budgets.filter(budget => budget.nganSachID !== nganSachID);
    localStorage.setItem('budgets', JSON.stringify(budgets));
    displayBudgets();
}

function editBudget(nganSachID) {
    const budgets = JSON.parse(localStorage.getItem('budgets')) || [];
    const budget = budgets.find(b => b.nganSachID === nganSachID);
    if (budget) {
        document.getElementById('nganSachID').value = budget.nganSachID;
        document.getElementById('duAnID').value = budget.duAnID;
        document.getElementById('soTien').value = budget.soTien;
        document.getElementById('moTa').value = budget.moTa;
        document.getElementById('ngayCapNhat').value = budget.ngayCapNhat;
    }
}
