import Swal from 'sweetalert2';
import 'sweetalert2/dist/sweetalert2.min.css';

const flashRoot = document.querySelector('[data-flash-success], [data-flash-error]');
const flashSuccess = flashRoot?.dataset.flashSuccess;
const flashError = flashRoot?.dataset.flashError;

const toast = Swal.mixin({
    toast: true,
    position: 'top-end',
    showConfirmButton: false,
    timer: 4200,
    timerProgressBar: true,
});

if (flashSuccess) {
    toast.fire({
        icon: 'success',
        title: flashSuccess,
    });
}

if (flashError) {
    Swal.fire({
        icon: 'error',
        title: 'เกิดข้อผิดพลาด',
        text: flashError,
        confirmButtonText: 'รับทราบ',
        confirmButtonColor: '#10b981',
    });
}

document.querySelectorAll('form.js-confirm').forEach((form) => {
    form.addEventListener('submit', async (event) => {
        if (event.submitter?.dataset.skipConfirm === '1') {
            return;
        }

        event.preventDefault();

        const result = await Swal.fire({
            icon: 'question',
            title: form.dataset.confirmTitle || 'ยืนยันการทำรายการ?',
            text: form.dataset.confirmText || 'ต้องการดำเนินการต่อใช่ไหม',
            showCancelButton: true,
            confirmButtonText: 'ยืนยัน',
            cancelButtonText: 'ยกเลิก',
            confirmButtonColor: '#10b981',
            cancelButtonColor: '#64748b',
            reverseButtons: true,
        });

        if (result.isConfirmed) {
            form.submit();
        }
    });
});
